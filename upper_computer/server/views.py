from django.shortcuts import render
from django.http import HttpResponse, JsonResponse
from rest_framework.views import APIView
from rest_framework.permissions import AllowAny
from rest_framework.parsers import *
import numpy as np
from PIL import Image, ImageDraw, ImageFont
from datetime import datetime
from base64 import b64encode

text_test = '''
    |--bowerrc
    |-- jshintrc
    |-- jshintrc2
    |-- Gruntfile.js
    |-- README.md
    |-- bower.json
    |-- karma.conf.js
    |-- package.json
    |-- app
        |-- app.js
        |-- db.js
        |-- directoryList.md
        |-- index.html
        |-- mddir.js
        |-- routing.js
        |-- server.js
        |-- api
        |   |-- api.groups.js
        |   |-- api.posts.js
        |   |-- api.users.js
        |   |-- api.widgets.js
        |-- components
        |   |-- directives
        |   |   |-- directives.module.js
        |   |   |-- vendor
        |   |       |-- directive.draganddrop.js
        |   |-- helpers
        |   |   |-- helpers.module.js
        |   |   |-- proprietary
        |   |       |-- factory.actionDispatcher.js
        |   |-- services
        |       |-- services.cardTemplates.js
        |       |-- services.cards.js
        |       |-- services.groups.js
        |       |-- services.posts.js
        |       |-- services.users.js
        |       |-- services.widgets.js
        |-- _mocks
            |-- mocks.groups.js
            |-- mocks.posts.js
            |-- mocks.users.js
            |-- mocks.widgets.js
    '''


# Create your views here.

class TestView(APIView):
    parser_classes = [JSONParser, ]  # 选择用于解析json请求体的解析器
    _indent = ["    ", "|   ", "|-- "]

    def post(self, request, *args, **kwargs):
        width = 900
        height = 1440

        client = request.data.get("client")
        operation = request.data.get("operation")
        root = request.data.get("root")
        response = {
            "size": {
                "width": width,
                "height": height
            },
            "img": ""
        }

        text = self._fileOperation(client, operation)
        text += self._generateRootStr(root)
        # print(text)
        img = Image.new('1', (width, height), 0)
        # img.show()
        draw = ImageDraw.Draw(img)
        font = ImageFont.truetype(r"C:\Windows\Fonts\Consolas\consola.ttf", 16)
        # draw.multiline_text((0, 0), text_test, fill=1, font=font)
        draw.multiline_text((10, 10), text, fill=1, font=font)
        img.show()
        img_arr = np.array(img)
        response["img"] = self._numpyBool2Str(np.array(img))
        print(len(response["img"]))
        return JsonResponse(response)

    def _fileOperation(self, client, operation):
        """
        文件操作格式化
        :param operation: 客户端信息
        :param operation: 文件操作信息
        :return: operation_str: 文件操作字符串信息
        """
        now = datetime.now()
        operation_str = str(now) + "    IP: " + client["ip"] + "    operation: "
        if operation["type"] // 10 == 1:  # 上传
            operation_str += "UPLOAD"
        elif operation["type"] // 10 == 2:  # 删除
            operation_str += "DELETE"
        elif operation["type"] // 10 == 3:  # 重命名
            operation_str += "RENAME"
        elif operation["type"] // 10 == 4:  # 下载
            operation_str += "DOWNLOAD"

        if operation["type"] % 10 == 1:  # 文件夹
            operation_str += " folder"
        elif operation["type"] % 10 == 2:  # 文件
            operation_str += " file"
        operation_str += '\n'
        operation_str += "    Original Path: " + operation["original_path"] + '\n'
        operation_str += "    Modified Path: " + operation["modified_path"] + '\n\n'

        return operation_str

    def _generateRootStr(self, root):
        """
        生成文件根目录字符串
        :param root: 序列化的 root
        :return: root_str, 用于在屏幕上显示文件目录的字符串
        """
        root_str = self._indent[2] + "root\n"
        string_prefix = self._indent[0]  # 每一行字符串前缀
        for i, value in enumerate(root):
            if isinstance(value, dict):
                index = i
            else:
                root_str += string_prefix + self._indent[2] + value + '\n'
        if index >= 0:
            length = len(root[index]) - 1  # 获取字典项(文件夹)数量
            for i, item in enumerate(root[index].items()):
                root_str += string_prefix + self._indent[2] + item[0] + '\n'
                if i < length:
                    root_str += self._generateFolderStr(item[1], string_prefix + self._indent[1])
                else:
                    root_str += self._generateFolderStr(item[1], string_prefix + self._indent[0])
        return root_str

    def _generateFolderStr(self, folder, string_prefix):
        """
        用于递归调用生成一个文件夹目录字符串
        :param folder: 文件夹 list
        :param string_prefix: 字符串前缀
        :return: folser_str, 文件夹的字符串, 最后以 '\n' 结尾
        """
        folder_str = ""
        index = -1
        for i, value in enumerate(folder):
            if isinstance(value, dict):
                index = i
            else:
                folder_str += string_prefix + self._indent[2] + value + '\n'
        if index >= 0:
            length = len(folder[index]) - 1  # 获取字典项(文件夹)数量
            for i, item in enumerate(folder[index].items()):
                folder_str += string_prefix + self._indent[2] + item[0] + '\n'
                if i < length:
                    folder_str += self._generateFolderStr(item[1], string_prefix + self._indent[1])
                else:
                    folder_str += self._generateFolderStr(item[1], string_prefix + self._indent[0])
        return folder_str

    def _numpyBool2Str(self, arr):
        """
        将bool类型的, numpy表示的图片数据进行base64编码
        :param arr: bool类型的numpy二维数组
        :return: base64字符串
        """
        height = np.size(arr, 0)
        width = np.size(arr, 1)
        counter = 0
        temp = 0
        string = ""
        for line in arr:
            for item in line:
                temp <<= 1
                if item:
                    temp += 1
                counter += 1
                if counter == 8:
                    string += chr(temp)
                    temp = 0
                    counter = 0
        # print(len(string))
        # return b64encode(string.encode("utf-8")).decode('ascii')
        return string
