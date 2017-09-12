Wisper.subscribe(VideoUpsertSnsPublisher.new, async: true, prefix: :on)
Wisper.subscribe(VideoDeleteSnsPublisher.new, async: true, prefix: :on)
Wisper.subscribe(CommentsDestroyer.new, async: true, prefix: :on)