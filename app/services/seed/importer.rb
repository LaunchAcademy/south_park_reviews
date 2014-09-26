class Importer
  attr_reader :file, :options

  def initialize(file, options = {})
    @file = file
    @options = default_options.merge(options)
  end

  def import
    CSV.foreach(file, options) do |row|
      create(row)
    end
  end
end
