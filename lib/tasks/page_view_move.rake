namespace :page_view_move do
  desc "Create new PageViewResult and set page_view count = 0"

  task :move_entrance => :environment do
    puts 'copy PageView object to PageViewResults'
    page_view = PageView.find_by_title('home_index')
    page_view_result = PageViewResult.new(page_view.as_json)
    page_view_result.day = DateTime.now.to_date
    page_view_result.save
    page_view.couunt = 0
    page_view.save
    puts 'done'
  end
end