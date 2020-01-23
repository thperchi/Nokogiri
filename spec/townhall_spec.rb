require_relative '../lib/townhall.rb'

describe "get_townhall_email method" do
	it "should return an hash with name and mail" do
		expect(get_townhall_email("https://www.annuaire-des-mairies.com/95/ableiges.html")).to be_an_instance_of(Hash)
		expect(get_townhall_email("https://www.annuaire-des-mairies.com/95/ableiges.html")).to eq ({"ABLEIGES"=>"mairie.ableiges95@wanadoo.fr"})
	end
	it "shouldn't return empty value" do
		expect(get_townhall_email("https://www.annuaire-des-mairies.com/95/menouville.html")).to eq ({"MENOUVILLE"=>"Email non fournis"})
	end
end