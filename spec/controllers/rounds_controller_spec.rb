require 'spec_helper'

describe RoundsController do
  before(:each) do
    stub_geocoder
    
    @round = Factory :round
    @controller.sign_in @round.user
  end

  it "should get index" do
    get :index
    
    should respond_with(:success)
    assigns(:rounds).should_not be_nil
  end

  it "should get new" do
    get :new
    
    should respond_with(:success)
  end
  
  it "should not get new if guest" do
    @controller.sign_out
    
    get :new
    
    should redirect_to(sign_in_url)
  end

  it "should create round" do
    Proc.new do
      post :create, :round => @round.attributes
    end.should change(Round, :count).by(1)

    should respond_with(:found)
    should redirect_to(round_path(assigns(:round)))
  end

  it "should always show round" do
    get :show, :id => @round.to_param
    
    should respond_with(:success)
    
    round = Factory :round
    
    get :show, :id => round.to_param
    
    should respond_with(:success)
    
    @controller.sign_out
    
    get :show, :id => @round.to_param
    
    should respond_with(:success)
  end

  it "should get edit if you own the round" do
    get :edit, :id => @round.to_param
    
    should respond_with(:success)
  end

  it "should not get edit if you don't own the round" do
    get :edit, :id => Factory(:round).to_param
    
    should redirect_to(sign_in_url)
  end
  
  it "should not get edit if guest" do
    @controller.sign_out
    
    get :edit, :id => @round.to_param
    
    should redirect_to(sign_in_url)
  end

  it "should update if you own the round" do
    put :update, :id => @round.to_param, :round => @round.attributes
    
    should respond_with(:found)
    should redirect_to(round_path(assigns(:round)))
  end
  
  it "should not update if you don't own the round" do
    round = Factory :round
    put :update, :id => round.to_param, :round => round.attributes
    
    should redirect_to(sign_in_url)
  end
  
  it "should not update if guest" do
    @controller.sign_out
    
    put :update, :id => @round.to_param, :round => @round.attributes
    
    should redirect_to(sign_in_url)
  end

  it "should destroy if you own the round" do
    Proc.new do
      delete :destroy, :id => @round.to_param
    end.should change(Round, :count).by(-1)

    should respond_with(:found)
    should redirect_to(rounds_path)
  end
  
  it "should not destroy if you don't own the round" do
    delete :destroy, :id => Factory(:round).to_param
    
    should redirect_to(sign_in_url)
  end
  
  it "should not destroy if guest" do
    @controller.sign_out
    
    delete :destroy, :id => @round.to_param
    
    should redirect_to(sign_in_url)
  end
  
  it "should confirm if you own the round" do
    @round.date = Time.now + 1.months
    @round.deadline = Time.now
    @round.save!
    
    @round.confirmable?.should == true
    
    put :confirm, :id => @round.to_param
    
    should respond_with(:found)
    should redirect_to(round_path(assigns(:round)))
    flash[:notice].should == 'Round was successfully confirmed.'
    assigns(:round).confirmed.should == true
  end
  
  it "should not confirm if the current time is before the deadline" do
    @round.date = Time.now + 2.months
    @round.deadline = Time.now + 1.month
    @round.save!
    
    put :confirm, :id => @round.to_param
    
    assigns(:round).errors.empty?.should == false
  end
  
  it "should not confirm if the current time is after the date" do
    @round.date = Time.now + 1.second
    @round.deadline = Time.now
    @round.save!
    
    sleep(2)
    put :confirm, :id => @round.to_param
    
    assigns(:round).errors.empty?.should == false
  end
  
  it "should not confirm if you don't own the round" do
    round = Factory :round
    put :confirm, :id => round.to_param
    
    should redirect_to(sign_in_url)
  end
  
  it "should not confirm if guest" do
    round = Factory :round
    put :confirm, :id => round.to_param
    
    should redirect_to(sign_in_url)
  end
end