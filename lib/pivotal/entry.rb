require 'date'

module Pivotal
  class Entry

    class << self
      def upload_to_pivotal(file)
        entries_from_hamster_tsv_export(file).map(&:post)
      end

      def dry_run(file)
        entries_from_hamster_tsv_export(file).map(&:pretty_print)
      end

      def entries_from_hamster_tsv_export(file)
        entries = []
        File.read(file).lines.each do |line|
          next if line =~ /^activity/
          entries << Entry.from_hamster_tsv_line(line) 
        end
        entries
      end

      def from_hamster_tsv_line(line)
        parts = line.split("\t")
        entry = new
        entry.start = DateTime.parse(parts[1])
        entry.end = DateTime.parse(parts[2])
        entry.description = parts[5]
        entry
      end
    end

    attr_accessor :start, :end, :description

    def invoice_time
      (((@end.to_time.to_i - @start.to_time.to_i) / 60) / 60.0).round(2)
    end

    # Round to increments of half hours
    def pivotal_time(fraction=0.5)
      multiplier = 1.0 / fraction
      val = (multiplier*invoice_time).round / multiplier
      val = 0.5 if val == 0
      val
    end

    # Make pivotal happy with the specified date format
    def pivotal_date
      @start.strftime("%m/%d/%Y")
    end

    def post
      Connection.instance.post_form("shift[person_id]=#{Connection::PERSON_ID}&shift[project_id]=#{Connection::PROJECT_ID}&shift[date]=#{self.pivotal_date}&shift[hours]=#{self.pivotal_time}&shift[description]=#{self.description}&commit=Save", "/time_shifts")
    end

    def pretty_print
      puts "#{self.pivotal_date} ::: #{self.description} ::: #{self.pivotal_time}"
    end
  end
end
