class CreateRelationships < ActiveRecord::Migration
  def change
    #t.references :follower, index: true、t.references :follower, index: true
    #の行にforeign_keyの指定がある場合は取り除いてください。
    #（取り除かないとレッスンの最後でHerokuにデプロイする際にエラーになります。）
    create_table :relationships do |t|
      t.references :follower, index: true
      t.references :followed, index: true

      t.timestamps null: false
      
      t.index [:follower_id, :followed_id], unique: true
    end
  end
end
