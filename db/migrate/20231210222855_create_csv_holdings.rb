class CreateCsvHoldings < ActiveRecord::Migration[7.1]
  def change
    create_table :csv_holdings do |t|

      t.timestamps
    end
  end
end
