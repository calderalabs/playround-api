require 'spec_helper'

describe QuicktourController do
  before(:each) do
    stub_geocoder
    
    @user = Factory :user_with_quicktour
    
    @controller.sign_in @user
  end
  
  it "should update if you own the user" do
    put :update, :user_id => @user.to_param, :format => 'json'

    should respond_with(:ok)
  end

  it "should not update if you don't own the user" do
    user = Factory :user_with_quicktour
    put :update, :user_id => user.to_param, :format => 'json'

    should respond_with(:unauthorized)
  end
  
  it "should not update if guest" do
    @controller.sign_out
    
    put :update, :user_id => Factory(:user_with_quicktour).to_param, :format => 'json'
    
    should respond_with(:unauthorized)
  end
  
  it "should destroy if you own the user" do
    Proc.new do
      delete :destroy, :user_id => @user.to_param, :format => 'json'
    end.should change(Quicktour, :count).by(-1)
    
    should respond_with(:ok)
  end

  it "should not destroy if you don't own the user" do
    delete :destroy, :user_id => Factory(:user_with_quicktour).to_param, :format => 'json'

    should respond_with(:unauthorized)
  end
  
  it "should not destroy if guest" do
    @controller.sign_out
    
    delete :destroy, :user_id => Factory(:user_with_quicktour).to_param, :format => 'json'
    
    should respond_with(:unauthorized)
  end
end
