require 'spec_helper'

describe 'Peep' do

  context "Demonstartion of how datamapper works" do

    it "should be created and the retrieved from the database" do
      expect(Peep.count).to eq(0)
      Peep.create(:content => "Testing text 123")
      expect(Peep.count).to eq(1)
      peep = Peep.first
      expect(peep.content).to eq("Testing text 123")
      peep.destroy
      expect(Peep.count).to eq(0)
    end
  end
end
