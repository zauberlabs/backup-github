require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

require "mocha"
require "ostruct"
require_relative "../lib/backup-github"

describe GithubAPIAdapter do
  
  before :each  do 
    @client = double()
    @github = GithubAPIAdapter.new(@client)
  end

  describe "repositories" do
    it "should retrieve repositories for an organization" do
      @client.should_receive(:repositories) {%w{repo1 repo2 repo3}}

      @github.repositories("org1").should eq(%w{repo1 repo2 repo3})
    end
  end

  describe "on_issues" do
    it "should retrieve open issues" do
      @client.should_receive(:list_issues).with("repo", {:page => 0, :state => "open"}) do
        [1,2,4].collect {|i| OpenStruct.new(:number => i)}
      end
      @client.should_receive(:list_issues).with("repo", {:page => 0, :state => "closed"}) {[]}
      @client.should_receive(:issue).at_least(:once) {"content"}

      data = []
      @github.on_issues("repo") {|r| data << r}
      data.should have(3).items
    end

    it "should retrieve closed issues" do
      @client.should_receive(:list_issues).with("repo", {:page => 0, :state => "closed"}) do
        [1,2,4].collect {|i| OpenStruct.new(:number => i)}
      end
      @client.should_receive(:list_issues).with("repo", {:page => 0, :state => "open"}) {[]}
      @client.should_receive(:issue).at_least(:once) {"content"}

      data = []
      @github.on_issues("repo") {|r| data << r}
      data.should have(3).items
    end

    it "should retrieve all issues pages" do
      @client.should_receive(:list_issues).exactly(12).times do |repo, opt |
        values = if opt[:page] < 5 
                   (1..10)
                 else
                   (1..4)
                 end
        values.collect {|i| OpenStruct.new(:number => i)}
      end
      @client.should_receive(:issue).at_least(:once) {"content"}

      data = []
      @github.on_issues("repo") { |r| data << r }
      data.should have(5*10*2 + 4*2).items
    end

    it "should retrieve issue content for each issue" do 
      @client.should_receive(:list_issues).twice do |repo, opt|
        if opt[:state] == "open"
          [1].collect {|i| OpenStruct.new(:number => i)}
        else
          []
        end
      end
      @client.should_receive(:issue).at_least(:once) {"content"}

      data = []
      @github.on_issues("repo") {|r| data << r}
      data.should have(1).items
      data[0].content.should eq("content")
    end
  end
end