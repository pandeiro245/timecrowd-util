class Timecrowd
  attr_accessor :client, :access_token

  def initialize(code=nil)

    key = ENV['TIMECROWD_KEY']
    secret = ENV['TIMECROWD_SECRET']
    token = ENV['TIMECROWD_TOKEN']

    self.client = OAuth2::Client.new(
      key,
      secret,
      site: 'https://timecrowd.net',
      ssl: { verify: false }
    )

    if token.nil?
      token = client.auth_code.get_token(
        code, 
        redirect_uri: 'urn:ietf:wg:oauth:2.0:oob'
      )
    end

    self.access_token = OAuth2::AccessToken.new(
      client, token
    )
    access_token
  end

  def get_team_task(team_id, id)
    url = "/api/v1/teams/#{team_id}/tasks/#{id}"
    puts url
    access_token.get(url).parsed
  end

  def update_team_task(team_id, id, body)
    url = "/api/v1/teams/#{team_id}/tasks/#{id}"
    puts url
    puts body.inspect
    access_token.put(url, body: body).parsed
  end

  def team_tasks(team_id, state = nil, page_id = 1, parent_id = nil)
    url = "/api/v1/teams/#{team_id}/tasks?state=#{state}&page=#{page_id}"
    url += "&parent_id=#{parent_id}" if parent_id.present?
    puts "team_tasks: #{url}"
    access_token.get(url).parsed
  end

  def team_task_time_entries(team_id, task_id)
    url = "/api/v1/teams/#{team_id}/tasks/#{task_id}/time_entries"
    puts url
    access_token.get(url).parsed
  end

  def get_team(team_id)
    access_token.get(
      "/api/v1/teams/#{team_id}"
    ).parsed
  end

  def report(team_id, from, to, format='json')
    url = "/api/v1/teams/#{team_id}/report.json?from=#{from}&to=#{to}&format=#{format}"
    # url += "&uncached=1"
    puts url
    access_token.get(url).parsed
  end

  def working_users
    access_token.get('/api/v1/user/working_users').parsed
  end

  def me
    access_token.get('/api/v1/user/info').parsed
  end

  def get_all_time_entries(user_id)
    page = 1
    all_entries = []
    loop do
      entries = get_time_entries(user_id, page)
      break if entries.blank?
      page += 1
      all_entries += entries
    end
    all_entries
  end

  def get_time_entries(user_id, page = 1)
    access_token.get("/api/v1/users/#{user_id}/time_entries?page=#{page}").parsed
  end
end
