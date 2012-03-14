class SendingJob < Struct.new(:msg) # Some Indian
  def perform
    Twitter.configure do |config|
      config.oauth_token = @account.oauth_token
      config.oauth_token_secret = @account.oauth_token_secret
    end
    Twitter::Client.new.update(msg)
  end  
end

class AccountsController < ApplicationController
  def twitter_auth
    Twitter.configure do |config|
      config.oauth_token = @account.oauth_token
      config.oauth_token_secret = @account.oauth_token_secret
    end
    @user = Twitter::Client.new
  end

  # GET /accounts
  # GET /accounts.xml
  def index
    @accounts = Account.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @accounts }
    end
  end

  # GET /accounts/1
  # GET /accounts/1.xml
  def show
    @account = Account.find(params[:id])

    if @account.provider == "twitter"
      twitter_auth
    end

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @account }
    end
  end

  # GET /accounts/new
  # GET /accounts/new.xml
  #def new
  #  @account = Account.new

  #  respond_to do |format|
  #    format.html # new.html.erb
  #    format.xml  { render :xml => @account }
  #  end
  #end

  # GET /accounts/1/edit
  def edit
    @account = Account.find(params[:id])
  end

  # POST /accounts
  # POST /accounts.xml
  def create
    auth = request.env["omniauth.auth"]
    @account = Account.find_by_provider_and_uid(auth['provider'], auth['uid']) || Account.create_with_omniauth(auth)
    redirect_to @account
  end

  # PUT /accounts/1
  # PUT /accounts/1.xml
  def update
    @account = Account.find(params[:id])

    respond_to do |format|
      if @account.update_attributes(params[:account])
        format.html { redirect_to(@account, :notice => 'Account was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @account.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def tweet
    @account = Account.find(params[:account_id])
    Delayed::Job.enqueue(SendingJob.new(params[:msg]), :run_at => params[:period].to_i.minutes.from_now)
    redirect_to account_path(params[:account_id])
  end

  # DELETE /accounts/1
  # DELETE /accounts/1.xml
  def destroy
    @account = Account.find(params[:id])
    @account.destroy

    respond_to do |format|
      format.html { redirect_to(accounts_url) }
      format.xml  { head :ok }
    end
  end
end
