require 'rails_helper'

feature 'Event user link' do
  given!(:users) do
    10.times.map do
      create :user
    end
  end
  context '3人のとき' do
    given(:event) { create :event, name: 'テストコード相談会' }
    background do
      users.take(3).each do |user|
        event.users << user
      end
      sign_in_as_active_user(users.first)
    end

    scenario 'イベント参加者のリンクをたどることができる' do
      visit event_path(event)
      expect(page).to have_content 'テストコード相談会'

      first_user = users[0]
      click_link nil, href: event_user_path(event, first_user.nickname)
      expect(page).to have_content first_user.introduction

      expect(page).to_not have_css '.prev-user'

      expect(page).to have_css '.next-user'
      within '.next-user' do
        click_link "#{users[1].name_or_nickname} >>"
      end
      expect(page).to have_content users[1].introduction

      within '.next-user' do
        click_link "#{users[2].name_or_nickname} >>"
      end
      expect(page).to have_content users[2].introduction

      expect(page).to_not have_css '.next-user'

      within '.prev-user' do
        click_link "<< #{users[1].name_or_nickname}"
      end
      expect(page).to have_content users[1].introduction
      within '.prev-user' do
        click_link "<< #{users[0].name_or_nickname}"
      end
      expect(page).to have_content users[0].introduction
    end
  end

  context '1人のとき' do
  end

  context '2人のとき' do
  end
end