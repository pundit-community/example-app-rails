require 'rails_helper'

RSpec.describe Blog, type: :model do
  describe 'fields' do
    it { is_expected.to respond_to(:name) }
    it { is_expected.to respond_to(:description) }
    it { is_expected.to respond_to(:user) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:user) }
  end
end
