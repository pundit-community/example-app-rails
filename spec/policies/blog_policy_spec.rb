require 'rails_helper'

describe BlogPolicy do
  subject { described_class.new(user, blog) }

  let(:resolved_scope) { described_class::Scope.new(user, Blog.all).resolve }
  let(:blog) { FactoryBot.create(:valid_blog) }

  context 'with visitors' do
    let(:user) { nil }

    it { expect(resolved_scope).to include(blog) }
    it { is_expected.to permit_only_actions(%i[index show]) }
    it { is_expected.to forbid_actions(%i[new create edit update destroy]) }
  end

  context 'with registered users' do
    let(:user) { FactoryBot.create(:registered_user) }

    it { expect(resolved_scope).to include(blog) }
    it { is_expected.to permit_only_actions(%i[index show]) }
    it { is_expected.to forbid_actions(%i[new create edit update destroy]) }

    context 'when registered user is the blog owner' do
      before { blog.user = user }

      it { is_expected.to permit_only_actions(%i[index show edit update destroy]) }
      it { is_expected.to forbid_new_and_create_actions }

      context 'blog has a post' do
        before { blog.posts << FactoryBot.create(:valid_post) }

        it { is_expected.to forbid_action(:destroy) }
      end
    end
  end

  context 'with administrators' do
    let(:user) { FactoryBot.create(:administrator) }
    let(:blog) { FactoryBot.create(:valid_blog) }

    it { expect(resolved_scope).to include(blog) }
    it { is_expected.to permit_all_actions }

    context 'blog has a post' do
      before { blog.posts << FactoryBot.create(:valid_post) }

      it { is_expected.to forbid_action(:destroy) }
    end
  end
end
