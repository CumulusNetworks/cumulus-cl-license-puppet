require 'spec_helper'
require 'pry'

provider_resource = Puppet::Type.type(:cumulus_license)
provider_class = provider_resource.provider(:cumulus)

describe provider_class do
  before(:all) do
    @src_url = 'http://192.168.10.1/switch.lic'
    @title = 'license'
    @resource = provider_resource.new(
      src: @src_url,
      name: @title
    )
    @provider = provider_class.new(@resource)
  end

  context 'operating system confine' do
    subject do
      provider_class.confine_collection.summary[:variable][:operatingsystem]
    end
    it { is_expected.to eq ['cumuluslinux'] }
  end

  describe 'create' do
    before do
      allow(@provider).to receive(:cl_license).with(
        ['-i', 'http://192.168.10.1/switch.lic']).once
    end
    it 'should run cl-license with the correct options' do
      @provider.create
    end
  end

  describe 'exists?' do
    describe 'when resource[:force] is true' do
      before do
        @resource2 = provider_resource.new(
          src: @src_url,
          name: @title,
          force: true
        )
        @provider2 = provider_class.new(@resource2)
      end
      subject { @provider2.exists? }
      it { is_expected.to be false }
    end

    describe 'when resource[:force] is false' do
      describe 'and license exists' do
        before do
          allow(@provider).to receive(:cl_license).and_return(
            'License installed')
        end
        subject { @provider.exists? }
        it { is_expected.to be true }
      end
      describe 'and license does not exists' do
        before do
          allow(@provider).to receive(:cl_license).and_raise(
            'Puppet::ExecutionFailure')
        end
        subject { @provider.exists? }
        it { is_expected.to be false }
      end
    end
  end
end
