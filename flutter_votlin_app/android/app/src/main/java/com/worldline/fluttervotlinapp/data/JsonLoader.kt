package com.worldline.fluttervotlinapp.data

import android.content.Context
import android.support.annotation.RawRes
import java.io.IOException
import java.nio.charset.Charset

class JsonLoader {

    fun loadJson(context: Context, @RawRes resource: Int): String? {
        val json: String
        try {
            val inputStream = context.resources.openRawResource(resource)
            val size = inputStream.available()
            val buffer = ByteArray(size)
            inputStream.read(buffer)
            inputStream.close()
            json = String(buffer, Charset.forName("UTF-8"))

        } catch (ex: IOException) {
            ex.printStackTrace()
            return null
        }

        return json
    }
}