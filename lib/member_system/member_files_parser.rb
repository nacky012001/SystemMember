module MemberSystem
  class MemberFilesParser
    MAX_ROWS = 100
    FIRST_RECORD_ROW = 4
    COLUMNS = %i(name gender age organization organization_position email number company company_position club club_position position referee)
               
    class << self
      def parse(files)
        parsed_rows = 0
        records = []

        files.each do |file|
          xlsx = Roo::Spreadsheet.open(file)
          sheet = xlsx.sheet(0)

          parsed_rows += sheet.last_row - FIRST_RECORD_ROW + 1
          raise ExceedMaximumRows if parsed_rows > MAX_ROWS
      
          records +=
            FIRST_RECORD_ROW.upto(sheet.last_row).map do |row|
              COLUMNS.each_with_index.inject({}) do |hash, (column_name, col)|
                hash[column_name] = xlsx.cell(row, col + 1)
                hash
              end 
            end
        end

        records
      end
    end 
  end
end
