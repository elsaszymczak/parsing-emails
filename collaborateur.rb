require 'csv'
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

  def buil_list(row)
    email = row['email']
    first_name = email.match(/^(\w+)/)[1].capitalize
    last_name = email.match(/(\w+)\@/)[1].capitalize
    scope_id = 14
    List.new(first_name: first_name, last_name: last_name, scope_id: scope_id, email: email)
  end

  private

  def load_csv
    csv_options = { col_sep: ',', quote_char: '"', headers: :first_row }
    CSV.foreach(csv_file_path, csv_options) do |row|
      @collaborateurs << buil_list(row)
    end
  end

  def save_csv
    csv_options = { headers: :first_row, col_sep: ',', force_quotes: true, quote_char: '"' }
    CSV.open(csv_file_path, 'wb', csv_options) do |csv|
      csv << List.headers
      @collaborateurs.each do |collaborateur|
        csv << collaborateur.to_csv_row
      end
    end
  end
end

