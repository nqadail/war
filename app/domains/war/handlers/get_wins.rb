module War
  module Handlers
    class GetWins
      class << self
        def call()
          sql = <<~EOT
            select u.email, count(email) wins
            from
            wins w join users u on u.id = w.user_id
            group by w.user_id;
          EOT

          records_array = ActiveRecord::Base.connection.execute(sql)
          records_array.as_json
        end
      end
    end
  end
end
