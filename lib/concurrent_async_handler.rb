class ConcurrentAsyncHandler < RethinkDB::AsyncHandler
  def run(&action)
    options[:query_handle_class] = AsyncQueryHandler
    yield
  end

  def handler
    callback
  end

  class AsyncQueryHandler < RethinkDB::QueryHandle
    def guarded_async_run(&b)
      Concurrent.global_io_executor.post(&b)
    end
  end
end

