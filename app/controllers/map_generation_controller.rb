class MapGenerationController < ApplicationController


  def index
    @isMap = params[:map] == '1'

    if @isMap
      @userId = current_user.id
      @user_skills = EduProgram.joins(:connection_user_courses).where(:connection_user_courses => {:id_user => @userId})


      specialities_courses_data = ConnectionSpecialityCourse.all
      specialities_count = Speciality.count

      specialities_weight = Array.new(specialities_count, 0)
      specialities_courses = Array.new
      specialities_courses_weight = Array.new
      specialities_courses_data.each_with_index do |item, index|
        specialities_weight[item.id_speciality - 1] += item.weight
        if specialities_courses[item.id_speciality - 1] == nil
          specialities_courses[item.id_speciality - 1] = [item.id_course]
          specialities_courses_weight[item.id_speciality - 1] = [item.weight]
        else
          specialities_courses[item.id_speciality - 1].push(item.id_course)
          specialities_courses_weight[item.id_speciality - 1].push(item.weight)
        end
      end


      @eduProgramCount = EduProgram.count #all courses Count

      @user_model_skills = Array.new(@eduProgramCount, 0) #array of model future population with current user skills

      @user_skills.each do |skill|
        @user_model_skills[skill.id - 1] = 1
      end


      # ============================ S T A R T   G E N E R A T I O N ===============================
      # generating start population
      start_population = get_population @user_model_skills, @user_skills.length
      is_find = false
      iteration_number = 0


      # do loop

      while iteration_number < 10 && !is_find

        # children
        children = become_parents start_population
        # get mutation
        mutation_children = get_mutation children
        reanimation_children = get_reanimation mutation_children, @user_skills.length

        population = start_population + reanimation_children
        population = population.uniq #delete dublicate

        population_weight = get_selection_weight population, specialities_courses, specialities_courses_weight
        population_prise = get_selection_prise population, population_weight, specialities_weight

        selection_map = get_selection_map population_prise


        start_population = Array.new
        selection_map.each do |new_population_item|
          start_population.push(new_population_item["population"])
        end

        if selection_map.first["prise"] >= 80
          is_find = true
        end

        iteration_number += 1
      end

      @result = selection_map.first
      @result_courses = EduProgram.joins(:connection_speciality_courses)
                            .select('connection_speciality_courses.weight, connection_speciality_courses.id_course, edu_programs.*')
                            .where(:connection_speciality_courses => {:id_speciality => @result['index'] + 1})
      @result_speciality = Speciality.find(@result['index'] + 1)
    end


  end

  def get_population(model, coursesCount)
    population_list = Array.new
    for i in 1..30
      population_list.push(model.clone)
    end

    generateCount = 32 - coursesCount
    population_list.each do |item|
      i = 0
      while i < generateCount do
        current_gen = Random.rand(model.length)
        if item[current_gen] == 0
          item[current_gen] = 2
          i += 1
        end
      end
    end

    return population_list
  end

  def become_parents(population)
    i = 0
    children = Array.new
    parent_length = population.first.length
    while i < population.length
      separation_gen = Random.rand(parent_length)
      first_child = population[i].clone
      second_child = population[i+1].clone

      for j in separation_gen..(parent_length - 1)
        first_child[j] = population[i+1][j]
        second_child[j] = population[i][j]
      end
      children.push(first_child, second_child)
      i += 2
    end

    return children
  end

  def get_mutation(children)
    aliens = Array.new

    children.each_with_index do |child, index|
      alien = child.clone
      mutation_gen = Random.rand(alien.length)
      if alien[mutation_gen] == 2
        alien[mutation_gen] = 0
      elsif alien[mutation_gen] == 0
        alien[mutation_gen] = 2
      end
      aliens.push(alien)
    end

    return aliens
  end

  def get_reanimation(mutation_children, users_skills_count)
    generate_count = 32 - users_skills_count
    reanimation_children = Array.new

    mutation_children.each do |item|
      reanimation_child = item.clone
      current_generated_count = item.select { |a| a == 2 }.length
      if current_generated_count < generate_count
        index = generate_count - current_generated_count

        i = 0
        while i < index do
          current_gen = Random.rand(reanimation_child.length)
          if reanimation_child[current_gen] == 0
            reanimation_child[current_gen] = 2
            i += 1
          end
        end

      elsif current_generated_count > generate_count
        index = current_generated_count - generate_count
        for i in 1..index
          reanimation_child[reanimation_child.index(2)] = 0
        end
      end
      reanimation_children.push(reanimation_child)
    end

    return reanimation_children
  end

  def get_selection_weight(population, specialities_courses, specialities_courses_weight)
    result_weight = Array.new
    population.each do |item|
      current_courses = item.each_index.select{|i| item[i] > 0}
      current_result_weight = Array.new(specialities_courses.length, 0)
      specialities_courses.each_with_index do |speciality_courses, index_speciality|
        current_courses.each do |current_course|
          current_course_index = speciality_courses.index(current_course + 1)
          if current_course_index != nil
            current_result_weight[index_speciality] += specialities_courses_weight[index_speciality][current_course_index]
          end
        end
      end
      result_weight.push(current_result_weight)
    end
    return result_weight
  end


  def get_selection_prise(population, population_weight, specialities_weight)
    result_prise = Array.new
    population_weight.each_with_index do |weights, population_index|
      current_result_prise = weights.map.with_index {|x, i| x * 100 / specialities_weight[i]}
      current_prise = Hash.new
      current_max_prise_index = current_result_prise.index(current_result_prise.max)
      current_max_prise = current_result_prise[current_max_prise_index]
      current_prise['prise'] = current_max_prise
      current_prise['index'] = current_max_prise_index
      current_prise['population'] = population[population_index]
      result_prise.push(current_prise)
    end
    return result_prise
  end

  def get_selection_map(population_prise)
    sort_population = population_prise.sort! { |x, y| x["prise"] <=> y["prise"] }
    return sort_population.clone.reverse!.slice(0, 30)
  end

  def new
  end

  def edit
  end
end
