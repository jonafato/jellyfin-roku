function VideoPlayer(id)

    content = VideoContent(id)

    video = m.scene.findNode("VideoPlayer")

    video.content = content

    video.setFocus(true)
    video.control = "play"

    return video

end function


function VideoContent(id) as object
    content = createObject("RoSGNode", "ContentNode")

    meta = ItemMetaData(id)
    content.title = meta.Name

    server = get_var("server")
    content.url = Substitute("{0}/emby/Videos/{1}/stream.mp4", server, id)
    content.url = content.url + "?Static=true"

    content = authorize_request(content)

    if server_is_https() then
        content.setCertificatesFile("common:/certs/ca-bundle.crt")
    end if

    return content

end function