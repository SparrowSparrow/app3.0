class MapGenerationController < ApplicationController


  def index
    @isMap = params[:map] == '1'

    if @isMap
      @userId = current_user.id
      @user_skills = EduProgram.joins(:connection_user_courses).where(:connection_user_courses => {:id_user => @userId})

      @eduProgramCount = EduProgram.count #all courses Count

      @user_model_skills = Array.new(@eduProgramCount, 0) #array of model future population with current user skills

      @user_skills.each do |skill|
        @user_model_skills[skill.id - 1] = 1
      end

      # generating start population
      start_population = get_population @user_model_skills, @user_skills.length
      # children
      children = become_parents start_population
      # get mutation
      mutation_children = get_mutation children
      reanimation_children = get_reanimation mutation_children, @user_skills.length

      population = start_population + reanimation_children
      population = population.uniq #delete dublicate

    end

     # debugger
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

  def new
  end

  def edit
  end
end
