require 'spec_helper'

describe Midway do
  it 'config_path' do
    expect(Midway.config_path).not_to be_nil
  end

  it 'config' do
    expect(Midway.config).not_to be_nil
  end
end
