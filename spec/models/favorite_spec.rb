require 'rails_helper'

describe Favorite do
  subject { FactoryGirl.build(:favorite) }

  it { should validate_presence_of :episode }
  it { should validate_presence_of :user }

  it { should belong_to :user }
  it { should belong_to :episode }

  it { should be_valid }


end
