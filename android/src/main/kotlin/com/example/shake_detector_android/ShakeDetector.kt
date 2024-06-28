package com.example.shake_detector_android

import android.content.Context
import android.hardware.Sensor
import android.hardware.SensorEvent
import android.hardware.SensorEventListener
import android.hardware.SensorManager
import io.flutter.plugin.common.EventChannel
import kotlin.math.abs
import kotlin.math.sqrt

class ShakeDetector(private val context: Context) : EventChannel.StreamHandler, SensorEventListener {
    private var sensorManager: SensorManager? = null
    private var accelerometer: Sensor? = null
    private var lastTime: Long = 0
    private var lastX = 0f
    private var lastY = 0f
    private var lastZ = 0f
    private val shakeThreshold = 2000

    private var eventSink: EventChannel.EventSink? = null

    fun startListening() {
        sensorManager = context.getSystemService(Context.SENSOR_SERVICE) as SensorManager
        accelerometer = sensorManager?.getDefaultSensor(Sensor.TYPE_ACCELEROMETER)
        sensorManager?.registerListener(this, accelerometer, SensorManager.SENSOR_DELAY_NORMAL)
    }

    fun stopListening() {
        sensorManager?.unregisterListener(this)
    }

    override fun onListen(arguments: Any?, eventSink: EventChannel.EventSink?) {
        this.eventSink = eventSink
        startListening()
    }

    override fun onCancel(arguments: Any?) {
        stopListening()
    }

    override fun onAccuracyChanged(sensor: Sensor?, accuracy: Int) {}

    override fun onSensorChanged(event: SensorEvent?) {
        val currentTime = System.currentTimeMillis()
        val timeDifference = currentTime - lastTime

        if (timeDifference > 100) {
            lastTime = currentTime

            val x = event?.values?.get(0) ?: 0f
            val y = event?.values?.get(1) ?: 0f
            val z = event?.values?.get(2) ?: 0f

            val deltaX = x - lastX
            val deltaY = y - lastY
            val deltaZ = z - lastZ

            lastX = x
            lastY = y
            lastZ = z

            // Calculate horizontal acceleration (X and Z axes)
            val horizontalAcceleration = sqrt((deltaX * deltaX + deltaZ * deltaZ).toDouble()) / timeDifference * 10000

            // Calculate vertical acceleration (Y axis)
            val verticalAcceleration = abs(deltaY.toDouble()) / timeDifference * 10000

            if (horizontalAcceleration > shakeThreshold || verticalAcceleration > shakeThreshold) {
                val shakeDirection = when {
                    horizontalAcceleration > shakeThreshold && verticalAcceleration > shakeThreshold -> "both"
                    horizontalAcceleration > shakeThreshold -> "horizontal"
                    else -> "vertical"
                }
                eventSink?.success(shakeDirection)
            }
        }
    }
}