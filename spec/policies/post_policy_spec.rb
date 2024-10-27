require 'rails_helper'

describe PostPolicy do
  subject { described_class.new(user, post) }

  let(:resolved_scope) { described_class::Scope.new(user, Post.all).resolve }

  context 'with visitors' do
    let(:user) { nil }
    let(:post) { FactoryBot.create(:published_post) }

    it { expect(resolved_scope).to include(post) }
    it { is_expected.to permit_only_actions(%i[index show]) }
    it { is_expected.to forbid_actions(%i[new create edit update destroy]) }

    context 'post is not published' do
      let(:post) { FactoryBot.create(:unpublished_post) }

      it { expect(resolved_scope).not_to include(post) }
      it { is_expected.to permit_only_actions((%i[index])) }
      it { is_expected.to forbid_actions(%i[show new create edit update destroy]) }
    end
  end

  context 'with registered users' do
    let(:user) { FactoryBot.create(:registered_user) }
    let(:post) { FactoryBot.create(:published_post) }

    it { expect(resolved_scope).to include(post) }
    it { is_expected.to permit_only_actions(%i[index show]) }
    it { is_expected.to forbid_actions(%i[new create edit update destroy]) }

    context 'post is not published' do
      let(:post) { FactoryBot.create(:unpublished_post) }

      it { expect(resolved_scope).not_to include(post) }
      it { is_expected.to permit_only_actions((%i[index])) }
      it { is_expected.to forbid_actions(%i[show new create edit update destroy]) }
    end
  end

  context 'with authors' do
    let(:user) { FactoryBot.create(:registered_user) }
    let(:post) { FactoryBot.create(:published_post, user: user) }

    it { expect(resolved_scope).to include(post) }
    it { is_expected.to permit_all_actions }

    context 'post is not published' do
      let(:post) { FactoryBot.create(:unpublished_post, user: user) }

      it { expect(resolved_scope).to include(post) }
      it { is_expected.to permit_all_actions }
    end
  end

  context 'with administrators' do
    let(:user) { FactoryBot.create(:administrator) }
    let(:post) { FactoryBot.create(:published_post) }

    it { expect(resolved_scope).to include(post) }
    it { is_expected.to permit_all_actions }

    context 'post is not published' do
      let(:post) { FactoryBot.create(:unpublished_post) }

      it { expect(resolved_scope).to include(post) }
      it { is_expected.to permit_all_actions }
    end
  end
end
