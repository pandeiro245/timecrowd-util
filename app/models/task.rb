class Task
  def initialize
    @tc = Timecrowd.new
  end
  def hoge
     params = {"time_entry"=>{"id"=>159752, "created_at"=>"2017-04-05T17:04:28.000Z", "updated_at"=>"2017-04-05T17:04:28.000Z", "started_at"=>"2017-04-05T17:04:28.000Z", "stopped_at"=>nil, "task"=>{"id"=>52319, "created_at"=>"2017-04-05T17:04:28.000Z", "updated_at"=>"2017-04-05T17:05:02.000Z", "title"=>"タスクA1", "url"=>"https://www.chatwork.com/#!rid69365876-1908004830", "sequential_id"=>2, "parent_id"=>52318}, "user"=>{"id"=>2273, "created_at"=>"2017-03-11T05:07:41.000Z", "updated_at"=>"2017-04-05T17:04:28.000Z", "nickname"=>"親チームAのオーナー", "avatar_url"=>"https://lh3.googleusercontent.com/-XdUIqdMkCWA/AAAAAAAAAAI/AAAAAAAAAAA/4252rscbv5M/photo.jpg", "time_zone"=>"UTC", "locale"=>"ja"}, "team"=>{"id"=>2701, "created_at"=>"2017-03-16T11:41:08.000Z", "updated_at"=>"2017-04-05T17:05:02.000Z", "name"=>"親チームA", "avatar_url"=>"https://timecrowd.s3.amazonaws.com/uploads/team/avatar/2701/thumb_unnamed", "parent_id"=>nil}}, "event"=>"entry_start", "task"=>{"time_entry"=>{"id"=>159752, "created_at"=>"2017-04-05T17:04:28.000Z", "updated_at"=>"2017-04-05T17:04:28.000Z", "started_at"=>"2017-04-05T17:04:28.000Z", "stopped_at"=>nil, "task"=>{"id"=>52319, "created_at"=>"2017-04-05T17:04:28.000Z", "updated_at"=>"2017-04-05T17:05:02.000Z", "title"=>"タスクA1", "url"=>"https://www.chatwork.com/#!rid69365876-1908004830", "sequential_id"=>2, "parent_id"=>52318}, "user"=>{"id"=>2273, "created_at"=>"2017-03-11T05:07:41.000Z", "updated_at"=>"2017-04-05T17:04:28.000Z", "nickname"=>"親チームAのオーナー", "avatar_url"=>"https://lh3.googleusercontent.com/-XdUIqdMkCWA/AAAAAAAAAAI/AAAAAAAAAAA/4252rscbv5M/photo.jpg", "time_zone"=>"UTC", "locale"=>"ja"}, "team"=>{"id"=>2701, "created_at"=>"2017-03-16T11:41:08.000Z", "updated_at"=>"2017-04-05T17:05:02.000Z", "name"=>"親チームA", "avatar_url"=>"https://timecrowd.s3.amazonaws.com/uploads/team/avatar/2701/thumb_unnamed", "parent_id"=>nil}}, "event"=>"entry_start"}}

   task_id = params['task']['time_entry']['task']['id']
   team_id = params['task']['time_entry']['team']['id']

   task = @tc.get_team_task(team_id, task_id)

   @tc.team_tasks(team_id).each do |task|
     puts "task['id'] is #{task['id']}, task['root_id'] is #{task['root_id']}"

     if task['id'] == task['root_id'] # 親タスク
        puts "#{task['title']}"
       if task['category'] == false
         puts "update #{task['title']}"
         @tc.update_team_task(team_id, task['id'], {task: {category: true}})
       end
     end 
   end
   task 
  end
end

