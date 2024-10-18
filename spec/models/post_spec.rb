require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'fields' do
    it { is_expected.to respond_to(:name) }
    it { is_expected.to respond_to(:description) }
    it { is_expected.to respond_to(:body) }
    it { is_expected.to respond_to(:publish) }
    it { is_expected.to respond_to(:user) }
    it { is_expected.to respond_to(:blog) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:blog) }
    it { is_expected.to belong_to(:user) }
  end
end
