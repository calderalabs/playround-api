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
    @round.date = Time.now + 2.months
    @round.deadline = Time.now + 1.month
    @round.save!
    
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
    @round.date = Time.now + 2.months
    @round.deadline = Time.now + 1.month
    @round.save!
    
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
  
  it "should not update if current time is past the deadline" do
    @round.date = Time.now + 1.second
    @round.deadline = Time.now
    @round.save!

    Time.stub(:now).and_return(@round.deadline + 10.seconds)
    put :update, :id => @round.to_param, :round => @round.attributes
    
    should redirect_to(sign_in_url)
    Time.unstub!(:now)
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
  
  it "should not destroy if there is at least one subscriber" do
    Factory :subscription, :round => @round
    
    delete :destroy, :id => @round.to_param
    
    should redirect_to(sign_in_url)
  end
  
  it "should not destroy if guest" do
    @controller.sign_out
    
    delete :destroy, :id => @round.to_param
    
    should redirect_to(sign_in_url)
  end
  
  # ability tests
  
  it "user can create rounds" do
    ability = Ability.new Factory :user
    ability.can?(:create, Round).should == true
  end

  it "guests can't create rounds" do
    ability = Ability.new User.new
    ability.cannot?(:create, Round).should == true
  end

  it "anyone can read any round" do
    ability = Ability.new Factory :user
    ability.can?(:read, @round).should == true
    ability = Ability.new @round.user
    ability.can?(:read, @round).should == true
    ability = Ability.new User.new
    ability.can?(:read, @round).should == true
  end

  it "user can only update rounds which he owns" do
    @round.date = Time.now + 2.months
    @round.deadline = Time.now + 1.month
    @round.save!

    ability = Ability.new @round.user
    ability.can?(:update, @round).should == true
    ability.cannot?(:update, Factory.build(:round)).should == true
  end

  it "user can only destroy rounds which he owns and that has no subscribers" do
    ability = Ability.new @round.user
    ability.can?(:destroy, @round).should == true
    ability.cannot?(:destroy, Factory.build(:round)).should == true

    @round.save!
    Factory :subscription, :round => @round

    ability.cannot?(:destroy, @round).should == true
  end

  it "user can only update rounds before the deadline" do
    ability = Ability.new @round.user
    @round.date = Time.now + 1.second
    @round.deadline = Time.now
    @round.save!

    Time.stub(:now).and_return(@round.deadline + 10.seconds)
    ability.cannot?(:update, @round).should == true
    Time.unstub!(:now)
  end
end