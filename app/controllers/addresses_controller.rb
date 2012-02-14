class AddressesController < ApplicationController
  require 'net/http'
  
  # def scrape
  #   url=URI.parse("http://www.missouri.edu/PF/pf.cgi")
  #   ("a".."z").each do |a|
  #     ("a".."z").each do |b|
  #       ("a".."z").each do |c|
  #         ("a".."z").each do |d|
  #           begin 
  #             post_args = {"first_name" => a + b + "*", "last_name" => c + d + "*"}
  #             resp, data = Net::HTTP.post_form(url, post_args)
  #             if resp.code == "200"
  #               parsed_data = parse(data)
  #               parsed_data.each do |x|
  #                 @address = Address.new({encoded_address: x[0], key: x[1]})
  #                 @address.save
  #               end
  #             end
  #           rescue
  #           end
  #   resp, data = Net::HTTP.post_form(url, post_args)
  # end
  # 
  # 
  # def parse(x)
  #   done = false
  #   results = []
  #   temp_results = []
  #   while done != true
  #     temp = x.index("decrypt")
  #     if temp == nil
  #       done = true
  #     else
  #       temp2 = x.index(";", temp)
  #       r = x[temp..temp2]
  #       x = x[temp2..-1]
  #       temp_results << r[8..-4]
  #     end
  #   end  
  #   temp_results.each do |x|
  #     t = x.split(",")
  #     results << [t[0][1..-2], t[1][2..-2]]
  #   end
  #   return results  
  # end
  # GET /addresses
  # GET /addresses.json
  def index
    @addresses = Address.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @addresses }
    end
  end

  # GET /addresses/1
  # GET /addresses/1.json
  def show
    @address = Address.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @address }
    end
  end

  # GET /addresses/new
  # GET /addresses/new.json
  def new
    @address = Address.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @address }
    end
  end

  # GET /addresses/1/edit
  def edit
    @address = Address.find(params[:id])
  end

  # POST /addresses
  # POST /addresses.json
  def create
    @address = Address.new(params[:address])

    respond_to do |format|
      if @address.save
        format.html { redirect_to @address, notice: 'Address was successfully created.' }
        format.json { render json: @address, status: :created, location: @address }
      else
        format.html { render action: "new" }
        format.json { render json: @address.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /addresses/1
  # PUT /addresses/1.json
  def update
    @address = Address.find(params[:id])

    respond_to do |format|
      if @address.update_attributes(params[:address])
        format.html { redirect_to @address, notice: 'Address was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @address.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /addresses/1
  # DELETE /addresses/1.json
  def destroy
    @address = Address.find(params[:id])
    @address.destroy

    respond_to do |format|
      format.html { redirect_to addresses_url }
      format.json { head :ok }
    end
  end
end
