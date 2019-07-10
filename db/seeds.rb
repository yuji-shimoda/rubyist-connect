def save?
  [true, false].sample
end

def introduction
  DummyTextJp.sentences(Random.rand(1..30)).split('。').join("。\n\n")
end

def puts_or_log(text)
  if Rails.env.test?
    Rails.logger.info text
  else
    puts text
  end
end

def event_name
  Faker::Config.locale = :ja
  languages = ['C' ,'Java' ,'Objective-C' ,'C++' ,'C#' ,'PHP' ,'JavaScript' ,'Python' ,'Visual Basic .NET' ,'Perl' ,'Visual Basic' ,'R' ,'Transact-SQL' ,'PL/SQL' ,'Pascal' ,'Delphi/Object Pascal' ,'Swift' ,'Ruby' ,'F#' ,'MATLAB']
  event_types = %w(勉強会 ハッカソン セミナー プログラミング大会 もくもく会 忘年会 ハンズオン 懇親会)
  place = Faker::Address.city
  "#{languages.sample}#{event_types.sample} in #{place}"
end

ApplicationRecord.transaction do
  puts_or_log "Destroying all users."
  User.destroy_all

  puts_or_log "Destroying all events."
  Event.destroy_all

  user_max = Rails.env.test? ? 10 : 1000
  user_max.times do |n|
    puts_or_log "Creating user (#{n + 1}/#{user_max})"
    user = User.new

    Faker::Config.locale = :en
    user.github_id = "#{Faker::Address.zip_code}#{n}"
    user.nickname = "#{Faker::Internet.slug(nil, '_')}_#{n}"

    # 任意の入力項目はランダムに設定する
    user.twitter_name = user.nickname if save?
    user.facebook_name = user.nickname if save?
    user.qiita_name = user.nickname if save?

    user.image = Faker::Avatar.image
    user.email = Faker::Internet.email if save?
    user.introduction = introduction if save?
    user.github_url = "https://github.com/#{user.nickname}"
    user.blog = "http://#{user.nickname}.example.com" if save?
    user.birthday = Faker::Date.between(60.years.ago, 10.years.ago) if save?

    Faker::Config.locale = :ja
    user.name = Faker::Name.name if save?
    user.location = Faker::Address.city if save?

    user.save!
  end

  event_max = Rails.env.test? ? 5 : 200
  participation_min_max = 0..100
  event_max.times do |n|
    puts_or_log "Creating event (#{n + 1}/#{event_max})"
    event = Event.new
    event.name = event_name
    event.save!

    users = User.active.order(Arel.sql('RAND()')).limit(participation_min_max.to_a.sample)
    event.users << users
  end
end