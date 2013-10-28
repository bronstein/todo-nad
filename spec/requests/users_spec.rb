
describe "Users page" do
  describe "GET /users" do
    it "works!" do
    
      get users_path
      response.status.should be(200)
    end
  end
end
