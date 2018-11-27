require 'csv'
require 'pry-byebug'
require_relative 'list'

class Collaborateur
  attr_reader :csv_file_path, :collaborateurs

  def initialize(csv_file_path)
    @csv_file_path = csv_file_path
    @collaborateurs = []
  end

  def write_csv(csv_file_path)
    load_csv
    save_csv
  end

  private

  def load_csv
    csv_options = { col_sep: ',', quote_char: '"', headers: :first_row }
    CSV.foreach(csv_file_path, csv_options) do |row|
      email = "#{row['email']}"
      first_name = email.match(/^(\w+)/)[1].capitalize
      last_name = email.match(/(\w+)\@/)[1].capitalize
      scope_id = 14
      @collaborateurs << List.new(first_name: first_name, last_name: last_name, scope_id: scope_id, email: email)
    end
  end

  def save_csv
    csv_options = { headers: :first_row, col_sep: ',', force_quotes: true, quote_char: '"' }
    CSV.open(csv_file_path, 'wb', csv_options) do |csv|
      csv << ["first_name", "last_name", "scope_id", "email"]
      @collaborateurs.each do |collaborateur|
        csv << [collaborateur.first_name, collaborateur.last_name, collaborateur.scope_id, collaborateur.email]
      end
    end
  end
end
