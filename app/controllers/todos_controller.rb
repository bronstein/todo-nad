class TodosController < ApplicationController
	
	before_filter :signed_in_user
	before_filter :correct_user,   only: :destroy

  # GET /todos
  # GET /todos.json
  def index
    @todos = Todo.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @todos }
    end
  end

  # GET /todos/1
  # GET /todos/1.json
  def show
    @todo = Todo.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @todo }
    end
  end

  # GET /todos/new
  # GET /todos/new.json
  def new
    @todo = Todo.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @todo }
    end
  end

  # GET /todos/1/edit
  def edit
    @todo = Todo.find(params[:id])
  end

  # POST /todos
  # POST /todos.json
  def create
    @todo = current_user.todos.build(params[:todo])
		@todo.important = set_new_important

    respond_to do |format|
      if @todo.save
        format.html { redirect_to current_user, notice: 'Todo was successfully created.' }
        format.json { render json: @todo, status: :created, location: @todo }
      else
        format.html { render action: "new" }
        format.json { render json: @todo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /todos/1
  # PUT /todos/1.json
  def update
    @todo = Todo.find(params[:id])

    respond_to do |format|
      if @todo.update_attributes(params[:todo])
        format.html { redirect_to current_user, notice: 'Todo was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @todo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /todos/1
  # DELETE /todos/1.json
  def destroy
    @todo = Todo.find(params[:id])
    @todo.destroy

    respond_to do |format|
      format.html { redirect_to current_user }
      format.json { head :no_content }
    end
  end

	def move_up
		@todo = Todo.find(params[:id])
		current_level = @todo.important
		next_level = current_level==1 ? 1 : current_level-1
		@todo_neighbor = current_user.todos.where(important: next_level).first
		@todo.update_attributes(:important => -1)
		@todo_neighbor.update_attributes(:important => current_level)
		@todo.update_attributes(:important => next_level)
		redirect_to current_user
	end

	def move_down
		@todo = Todo.find(params[:id])
		current_level = @todo.important
		next_level = current_level+1
		@todo_neighbor = Todo.where(important: next_level).first
		@todo.update_attributes(:important => -1)
		@todo_neighbor.update_attributes(:important => current_level)
		@todo.update_attributes(:important => next_level)
		redirect_to current_user
	end

	private

    def correct_user
      @todo = current_user.todos.find_by_id(params[:id])
      redirect_to users_path if @todo.nil?
    end

		def set_new_important
			important_no = current_user.todos.count + 1
		end
end
