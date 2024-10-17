require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'fields' do
    it { is_expected.to respond_to(:administrator) }
  end

  describe 'associations' do
    it { is_expected.to have_one(:blog) }
  end
end
