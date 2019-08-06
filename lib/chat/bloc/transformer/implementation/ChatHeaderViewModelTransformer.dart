import 'package:farmsmart_flutter/chat/model/form/form_entity.dart';
import 'package:farmsmart_flutter/chat/ui/widgets/header_message.dart';

import 'package:farmsmart_flutter/chat/bloc/transformer/Transformer.dart';

class _Constants {
  static const defaultAssetImageSource = "assets/icons/chatbot_avatar.png";
}

class ChatHeaderViewModelTransformer
    implements ObjectTransformer<FormEntity, HeaderMessageViewModel> {
  @override
  HeaderMessageViewModel transform({from}) {
    return HeaderMessageViewModel(
      title: from.title,
      subtitle: from.subtitle,
      backgroundAssetImageSource: _Constants.defaultAssetImageSource,
    );
  }
}
