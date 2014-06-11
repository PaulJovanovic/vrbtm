class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string :name
    end

    ["art","anonymous","animals","beauty","business","death","dreams","emotion","education","equality","fact","faith","family","famous","food","friendship","funny","gender","happy","health","history","home","hope","inspirational","language","life","literature","love","lyrics","medical","money","motivational","movies","music","nature","news","parenting","patriotism","peace","philosophy","poetry","politics","prayer","proverb","relationship","religion","romantic","science","society","sports","success","speech","technology","time","truth","tv","war","wisdom","work","world"].each do |tag_name|
      Tag.create(name: tag_name)
    end
  end
end
