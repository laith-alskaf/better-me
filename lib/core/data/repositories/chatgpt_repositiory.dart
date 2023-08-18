
import 'package:dartz/dartz.dart';
import 'package:BetterMe/core/data/models/api/ChatGptModel.dart';
import 'package:BetterMe/core/data/models/common_respons.dart';
import 'package:BetterMe/core/data/network/endpoints/chat_gpt_endpoints.dart';
import 'package:BetterMe/core/data/network/network_config.dart';
import 'package:BetterMe/core/enums/request_type.dart';
import 'package:BetterMe/core/utils/network_utils.dart';


class ChatGPTRepositiory {
  Future<Either<String, List<ChatGptModel>>> sendMessage({
    required String messages,
  }) async {
    try {
      return NetworkUtil.sendRequest(
          type: RequestType.POST,
          url: ChatGPTEndPoints.getAllChatGPT,
          headers: NetworkConfig.getHeaders(
              needAuth: true,
              type: RequestType.POST,
              extraHeaders: {
                'Accept-Language': 'ar',
              }),
          body: {
            "model": "gpt-3.5-turbo",
            'messages': [
              {'role': 'system', 'content': 'أنت مساعد مفيد.'},
              {'role': 'user', 'content': messages},
            ],
          }).then((response) {
            if(response!=null){
              CommonResponse<List<dynamic>> commonResponse =
              CommonResponse.fromJson(response);
              if (commonResponse.getStatus) {
                List<ChatGptModel> result = [];
                commonResponse.data.forEach(
                      (element) {
                    result.add(ChatGptModel.fromJson(element));
                  },
                );
                return Right(result);
              }
              else {
                return Left(commonResponse.message ?? '');
              }
            }
            else{
                return const Left('');
            }

      });
    } catch (e) {
      return Left(e.toString());
    }
  }
}
