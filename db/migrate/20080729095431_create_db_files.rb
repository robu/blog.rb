class CreateDbFiles < ActiveRecord::Migration
  def self.up
    create_table :db_files do |t|
      t.binary :data, :limit => 10.megabytes

      t.timestamps
    end
  end

  def self.down
    drop_table :db_files
  end
end
