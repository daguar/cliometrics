require 'cliometrician'
require 'vcr'
require 'webmock'
require 'pry'

VCR.configure do |c|
  c.cassette_library_dir = 'spec/fixtures/vcr_cassettes'
  c.hook_into :webmock
end

describe Cliometrician do
  it 'exists' do
    Cliometrician.should_not be_nil
  end

  describe '#initialize' do
    context 'valid year' do
      let(:valid_year) { 2013 }

      it 'instantiates successfully' do
        expect {
          Cliometrician.new(valid_year)
        }.to_not raise_error
      end
    end

    context 'invalid year' do
      let(:invalid_year) { 2010 }

      it "raises with 'Bad year'" do
        expect {
          Cliometrician.new(invalid_year)
        }.to raise_error(RuntimeError, "Bad year")
      end
    end

    context 'no GitHub token present in env' do
      before do
        ENV.stub(:[]).with('GITHUB_TOKEN') { nil }
      end

      it 'raises' do
        expect {
          Cliometrician.new(2013)
        }.to raise_error(RuntimeError)
      end
    end
  end

  describe '#get_commits_for' do
    let(:clio) { Cliometrician.new(2013) }

    let(:decider_commits) do
      VCR.use_cassette('decider_commits') do
        decider_commits = clio.get_commits_for("the_decider")
      end
    end

    it 'gets the correct number of commits' do
      expect(decider_commits.length).to eq(4)
    end
  end
end
