class SearchString < ActiveRecord::Base
    require "net/http"
    def self.scrape_speeder_last_name
      url=URI.parse("http://www.missouri.edu/PF/pf.cgi")
      ("a".."z").each do |a|
        ("a".."z").each do |b|
          post_args = {"last_name" => a+b + "*"}
          resp, data = Net::HTTP.post_form(url, post_args)
          if resp.code == "200" && data.match("0 matches") != nil && data.match("30 matches found") == nil
            puts "blank last name set found...marking as done"
            SearchString.where(:last_name => a+b).each do |x|
              x.completed = 0
              x.save
            end
          end
        end
      end
            
    end
    def self.scrape_speeder_first_name
      url=URI.parse("http://www.missouri.edu/PF/pf.cgi")
      ("a".."z").each do |a|
        ("a".."z").each do |b|
          post_args = {"first_name" => a+b + "*"}
          resp, data = Net::HTTP.post_form(url, post_args)
          if resp.code == "200" && data.match("0 matches") != nil && data.match("30 matches found") == nil
            puts "blank last name set found...marking as done"
            SearchString.where(:first_name => a+b).each do |x|
              x.completed = 0
              x.save
            end
          end
        end
      end
            
    end      
          
    def self.scrape
      url=URI.parse("http://www.missouri.edu/PF/pf.cgi")
      SearchString.where(:completed => nil).limit(1000).each do |ss|
            
                post_args = {"first_name" => ss.first_name + "*", "last_name" => ss.last_name + "*"}
                puts post_args
                resp, data = Net::HTTP.post_form(url, post_args)
                puts resp
                if resp.code == "200"
                  if data.match("More than 30 matches found")
                    ss.completed = 99
                    ss.save
                  else
                    ss.completed=1
                    ss.save
                    puts "request completed"
                    parsed_data = SearchString.parse(data)
                    parsed_data.each do |x|
                      puts x
                      @address = Address.new({encoded_address: x[0], key: x[1]})
                      @address.save
                    end
                  end
                else
                  ss.completed = 404
                  ss.save
                end
          puts ss.first_name + "     " + ss.last_name
          puts Address.count
          end
    # redirect_to :action => "index"

  end
  def self.parse(x)
    done = false
    results = []
    temp_results = []
    while done != true
      temp = x.index("decrypt")
      if temp == nil
        done = true
      else
        temp2 = x.index(";", temp)
        r = x[temp..temp2]
        x = x[temp2..-1]
        temp_results << r[8..-4]
      end
    end  
    temp_results.each do |x|
      t = x.split(",")
      results << [t[0][1..-2], t[1][2..-2]]
    end
    return results  
  end
  


end
