require "spec_helper"

RSpec.describe Ruboty::Mastodon do
  it "has a version number" do
    expect(Ruboty::Mastodon::VERSION).not_to be nil
  end
end
