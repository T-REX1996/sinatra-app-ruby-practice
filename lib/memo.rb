# frozen_string_literal: true

require 'pg'

class Memo
  class << self
    # 接続はクラスで1つだけ作り、使い回す
    def connection
      @connection ||= PG.connect(dbname: ENV.fetch('DB_NAME', 'memo_app')).tap do |conn|
        conn.type_map_for_results = PG::BasicTypeMapForResults.new(conn)
      end
    end

    def all
      connection.exec('SELECT id, title, body, created_at FROM memos ORDER BY id').to_a
    end

    def find(id)
      connection.exec_params(
        'SELECT id, title, body, created_at FROM memos WHERE id = $1', [id.to_i]
      ).first
    end

    def create(title:, body:)
      connection.exec_params(
        'INSERT INTO memos (title, body) VALUES ($1, $2)', [title, body]
      )
    end

    def update(id:, title:, body:)
      connection.exec_params(
        'UPDATE memos SET title = $1, body = $2 WHERE id = $3', [title, body, id.to_i]
      )
    end

    def destroy(id)
      connection.exec_params('DELETE FROM memos WHERE id = $1', [id.to_i])
    end
  end
end
