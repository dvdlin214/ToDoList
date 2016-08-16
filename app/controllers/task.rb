post '/tasks/create' do
  @task= Task.new(params[:task])
  if request.xhr?
    if @task.save
      content_type :json
      @task.to_json
    end
  else
    if @task.save
      erb :"/lists/#{@task.list_id}"
    else
      @errors=@task.errors.full_messages
      erb :"/lists/#{@task.list_id}"
    end
  end
end


