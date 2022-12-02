class TestUtil
  def self.load_fixture_data
    require 'json'

    caller_filename = caller_locations.first.path
    fixture_dirname = File.dirname(caller_filename)
    fixture_basename = File.basename(caller_filename, '.rb') + '.json'
    fixture_filename = fixture_dirname + '/' + fixture_basename

    JSON.parse(File.read(fixture_filename))
  end
end
