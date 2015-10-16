class CreateMicroposts < ActiveRecord::Migration
  def change
    create_table :microposts do |t|
      #index:true を指定することで、user_idに対してインデックスを作成
      #foreign_key:true を指定することで、外部キー制約を設定し、usersテーブルに存在するidのみuser_idに入るようにしている
      t.references :user, index: true, foreign_key: true
      t.text :content

      t.timestamps null: false
      
      #投稿を指定ユーザで絞り込んだ後、作成時間で検索や並び替えを行う処理が速く行えるようになる
      t.index [:user_id,:created_at]
    end
  end
end
