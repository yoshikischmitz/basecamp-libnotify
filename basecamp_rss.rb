#Basecamp RSS Notifier Daemon Script by Yoshiki Schmitz
#Queries a Basecamp Project RSS feed and displays new posts using lib-notify

require 'json'
require 'rss'
require 'nokogiri'

def parse_xml(xml)
  Nokogiri::HTML(xml)
end

def item_in_archive?(item_id, archive)
  archive.each_line do |archive_item_id|
    if archive_item_id.chomp == item_id
     return true
   end
  end
  #if there are no matches add item to archive 
  archive.puts item_id
end

def strip_html(html)
  html.gsub(/&lt;.+&gt;/s) {""}
end

def find_profile_image(accesses_link, person, user_and_pass)
  open(accesses_link, http_basic_authentication: user_and_pass) do |raw_json|
    parsed_json = JSON.parse(raw_json.read)
    parsed_json.each do |x|
      if x["name"] == person
        open x["avatar_url"] { |f|
          File.open("image.gif", "wb") do |file|
            file.puts f.read
          end
        }
      end
    end
  end
end

def send_notification(item)
  #takes a RSS entry object
  current_item_title = strip_html item.title.to_s
  current_item_text = strip_html item.content.to_s

  notification_title = parse_xml(current_item_title).content
  notification_text = parse_xml(current_item_text).content
	curr_dir = File.expand_path(File.dirname(__FILE__))
	system("notify-send -i #{curr_dir}/image.gif '#{notification_title}' '#{notification_text}'")
end

config_file= "config"
config_info = File.open(config_file).read.split("\n")
user_and_pass = config_info[0..1]
feed_url = config_info[2]
accesses_link = config_info[3]

loop do
  open(feed_url, http_basic_authentication: user_and_pass) do |rss|
    feed = RSS::Parser.parse(rss)
    feed.items.each do |item|
      archive = File.open("archive", "a+")
      item_id = parse_xml(item.to_s).css("id").first.content
      person = parse_xml(item.to_s).css("name").first.content
      find_profile_image(accesses_link, person, user_and_pass)
      send_notification(item) unless item_in_archive?(item_id, archive)
    end
  end
  sleep 60 
end
