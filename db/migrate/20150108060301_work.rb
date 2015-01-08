
  require 'lhm'


class Work < ActiveRecord::Migration
	
  def self.up
    Lhm.change_table :users do |m|
      m.add_column :arbitrary, "INT(12)"
    end
  end
end
