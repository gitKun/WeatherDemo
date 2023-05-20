//
//  XTHotReportModel.swift
//  WeatherDemo
//
//  Created by liyakun on 2023/5/20.
//

import Foundation


struct XTHotReport: Codable {

    let count: Int?
    let cursor: String?
    let data: [ResponeData]?
    let errMsg: String?
    let errNo: Int?
    let hasMore: Bool?

    enum CodingKeys: String, CodingKey {
        case count = "count"
        case cursor = "cursor"
        case data = "data"
        case errMsg = "err_msg"
        case errNo = "err_no"
        case hasMore = "has_more"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        count = try values.decodeIfPresent(Int.self, forKey: .count)
        cursor = try values.decodeIfPresent(String.self, forKey: .cursor)
        data = try values.decodeIfPresent([ResponeData].self, forKey: .data)
        errMsg = try values.decodeIfPresent(String.self, forKey: .errMsg)
        errNo = try values.decodeIfPresent(Int.self, forKey: .errNo)
        hasMore = try values.decodeIfPresent(Bool.self, forKey: .hasMore)
    }
}

struct ResponeData: Codable {

    let authorUserInfo: AuthorUserInfo?
    let diggUser: [AuthorUserInfo]?
    let hotComment: HotComment?
    let isSelected: Bool?
    let msgInfo: MsgInfo?
    let msgId: String?
    let org: Org?
    let theme: Theme?
    let topic: Topic?
    let userInteract: UserInteract?

    enum CodingKeys: String, CodingKey {
        case authorUserInfo
        case diggUser = "digg_user"
        case hotComment
        case isSelected = "is_selected"
        case msgInfo
        case msgId = "msg_id"
        case org
        case theme
        case topic
        case userInteract
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        authorUserInfo = try values.decodeIfPresent(AuthorUserInfo.self, forKey: .authorUserInfo)
        diggUser = try values.decodeIfPresent([AuthorUserInfo].self, forKey: .diggUser)
        hotComment = try values.decodeIfPresent(HotComment.self, forKey: .hotComment)
        isSelected = try values.decodeIfPresent(Bool.self, forKey: .isSelected)
        msgInfo = try values.decodeIfPresent(MsgInfo.self, forKey: .msgInfo)
        msgId = try values.decodeIfPresent(String.self, forKey: .msgId)
        org = try values.decodeIfPresent(Org.self, forKey: .org)
        theme = try values.decodeIfPresent(Theme.self, forKey: .theme)
        topic = try values.decodeIfPresent(Topic.self, forKey: .topic)
        userInteract = try values.decodeIfPresent(UserInteract.self, forKey: .userInteract)
    }
}

struct UserInteract: Codable {

    let collectSetCount: Int?
    let idField: Int?
    let isCollect: Bool?
    let isDigg: Bool?
    let isFollow: Bool?
    let omitempty: Int?
    let userId: Int?

    enum CodingKeys: String, CodingKey {
        case collectSetCount = "collect_set_count"
        case idField = "id"
        case isCollect = "is_collect"
        case isDigg = "is_digg"
        case isFollow = "is_follow"
        case omitempty = "omitempty"
        case userId = "user_id"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        collectSetCount = try values.decodeIfPresent(Int.self, forKey: .collectSetCount)
        idField = try values.decodeIfPresent(Int.self, forKey: .idField)
        isCollect = try values.decodeIfPresent(Bool.self, forKey: .isCollect)
        isDigg = try values.decodeIfPresent(Bool.self, forKey: .isDigg)
        isFollow = try values.decodeIfPresent(Bool.self, forKey: .isFollow)
        omitempty = try values.decodeIfPresent(Int.self, forKey: .omitempty)
        userId = try values.decodeIfPresent(Int.self, forKey: .userId)
    }
}

struct Topic: Codable {

    let adminIds: [String]?
    let attenderCount: Int?
    let cateId: String?
    let descriptionField: String?
    let followerCount: Int?
    let icon: String?
    let isRec: Bool?
    let msgCount: Int?
    let notice: String?
    let recRank: Int?
    let themeIds: [String]?
    let title: String?
    let topicId: String?

    enum CodingKeys: String, CodingKey {
        case adminIds = "admin_ids"
        case attenderCount = "attender_count"
        case cateId = "cate_id"
        case descriptionField = "description"
        case followerCount = "follower_count"
        case icon = "icon"
        case isRec = "is_rec"
        case msgCount = "msg_count"
        case notice = "notice"
        case recRank = "rec_rank"
        case themeIds = "theme_ids"
        case title = "title"
        case topicId = "topic_id"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        adminIds = try values.decodeIfPresent([String].self, forKey: .adminIds)
        attenderCount = try values.decodeIfPresent(Int.self, forKey: .attenderCount)
        cateId = try values.decodeIfPresent(String.self, forKey: .cateId)
        descriptionField = try values.decodeIfPresent(String.self, forKey: .descriptionField)
        followerCount = try values.decodeIfPresent(Int.self, forKey: .followerCount)
        icon = try values.decodeIfPresent(String.self, forKey: .icon)
        isRec = try values.decodeIfPresent(Bool.self, forKey: .isRec)
        msgCount = try values.decodeIfPresent(Int.self, forKey: .msgCount)
        notice = try values.decodeIfPresent(String.self, forKey: .notice)
        recRank = try values.decodeIfPresent(Int.self, forKey: .recRank)
        themeIds = try values.decodeIfPresent([String].self, forKey: .themeIds)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        topicId = try values.decodeIfPresent(String.self, forKey: .topicId)
    }
}

struct Theme: Codable {

    let brief: String?
    let cover: String?
    let ctime: Int?
    let hot: Int?
    let isLottery: Bool?
    let isRec: Bool?
    let lastHot: Int?
    let lotteryBeginTime: Int?
    let lotteryEndTime: Int?
    let mtime: Int?
    let name: String?
    let recRank: Int?
    let status: Int?
    let themeId: String?
    let themeType: Int?
    let topicIds: [String]?
    let userCnt: Int?
    let viewCnt: Int?

    enum CodingKeys: String, CodingKey {
        case brief = "brief"
        case cover = "cover"
        case ctime = "ctime"
        case hot = "hot"
        case isLottery = "is_lottery"
        case isRec = "is_rec"
        case lastHot = "last_hot"
        case lotteryBeginTime = "lottery_begin_time"
        case lotteryEndTime = "lottery_end_time"
        case mtime = "mtime"
        case name = "name"
        case recRank = "rec_rank"
        case status = "status"
        case themeId = "theme_id"
        case themeType = "theme_type"
        case topicIds = "topic_ids"
        case userCnt = "user_cnt"
        case viewCnt = "view_cnt"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        brief = try values.decodeIfPresent(String.self, forKey: .brief)
        cover = try values.decodeIfPresent(String.self, forKey: .cover)
        ctime = try values.decodeIfPresent(Int.self, forKey: .ctime)
        hot = try values.decodeIfPresent(Int.self, forKey: .hot)
        isLottery = try values.decodeIfPresent(Bool.self, forKey: .isLottery)
        isRec = try values.decodeIfPresent(Bool.self, forKey: .isRec)
        lastHot = try values.decodeIfPresent(Int.self, forKey: .lastHot)
        lotteryBeginTime = try values.decodeIfPresent(Int.self, forKey: .lotteryBeginTime)
        lotteryEndTime = try values.decodeIfPresent(Int.self, forKey: .lotteryEndTime)
        mtime = try values.decodeIfPresent(Int.self, forKey: .mtime)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        recRank = try values.decodeIfPresent(Int.self, forKey: .recRank)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
        themeId = try values.decodeIfPresent(String.self, forKey: .themeId)
        themeType = try values.decodeIfPresent(Int.self, forKey: .themeType)
        topicIds = try values.decodeIfPresent([String].self, forKey: .topicIds)
        userCnt = try values.decodeIfPresent(Int.self, forKey: .userCnt)
        viewCnt = try values.decodeIfPresent(Int.self, forKey: .viewCnt)
    }
}

struct Org: Codable {

    let isFollowed: Bool?
    let orgInfo: String?

    enum CodingKeys: String, CodingKey {
        case isFollowed = "is_followed"
        case orgInfo = "org_info"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        isFollowed = try values.decodeIfPresent(Bool.self, forKey: .isFollowed)
        orgInfo = try values.decodeIfPresent(String.self, forKey: .orgInfo)
    }
}

struct MsgInfo: Codable {

    let auditStatus: Int?
    let commentCount: Int?
    let commentScore: Int?
    let content: String?
    let ctime: String?
    let diggCount: Int?
    let hotIndex: Float?
    let idField: Int?
    let isAdvertRecommend: Bool?
    let jcodeId: String?
    let msgId: String?
    let mtime: String?
    let picList: [String]?
    let rankIndex: Float?
    let rtime: String?
    let status: Int?
    let themeId: String?
    let topicId: String?
    let url: String?
    let urlPic: String?
    let urlTitle: String?
    let userId: String?
    let verifyStatus: Int?

    enum CodingKeys: String, CodingKey {
        case auditStatus = "audit_status"
        case commentCount = "comment_count"
        case commentScore = "comment_score"
        case content = "content"
        case ctime = "ctime"
        case diggCount = "digg_count"
        case hotIndex = "hot_index"
        case idField = "id"
        case isAdvertRecommend = "is_advert_recommend"
        case jcodeId = "jcode_id"
        case msgId = "msg_id"
        case mtime = "mtime"
        case picList = "pic_list"
        case rankIndex = "rank_index"
        case rtime = "rtime"
        case status = "status"
        case themeId = "theme_id"
        case topicId = "topic_id"
        case url = "url"
        case urlPic = "url_pic"
        case urlTitle = "url_title"
        case userId = "user_id"
        case verifyStatus = "verify_status"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        auditStatus = try values.decodeIfPresent(Int.self, forKey: .auditStatus)
        commentCount = try values.decodeIfPresent(Int.self, forKey: .commentCount)
        commentScore = try values.decodeIfPresent(Int.self, forKey: .commentScore)
        content = try values.decodeIfPresent(String.self, forKey: .content)
        ctime = try values.decodeIfPresent(String.self, forKey: .ctime)
        diggCount = try values.decodeIfPresent(Int.self, forKey: .diggCount)
        hotIndex = try values.decodeIfPresent(Float.self, forKey: .hotIndex)
        idField = try values.decodeIfPresent(Int.self, forKey: .idField)
        isAdvertRecommend = try values.decodeIfPresent(Bool.self, forKey: .isAdvertRecommend)
        jcodeId = try values.decodeIfPresent(String.self, forKey: .jcodeId)
        msgId = try values.decodeIfPresent(String.self, forKey: .msgId)
        mtime = try values.decodeIfPresent(String.self, forKey: .mtime)
        picList = try values.decodeIfPresent([String].self, forKey: .picList)
        rankIndex = try values.decodeIfPresent(Float.self, forKey: .rankIndex)
        rtime = try values.decodeIfPresent(String.self, forKey: .rtime)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
        themeId = try values.decodeIfPresent(String.self, forKey: .themeId)
        topicId = try values.decodeIfPresent(String.self, forKey: .topicId)
        url = try values.decodeIfPresent(String.self, forKey: .url)
        urlPic = try values.decodeIfPresent(String.self, forKey: .urlPic)
        urlTitle = try values.decodeIfPresent(String.self, forKey: .urlTitle)
        userId = try values.decodeIfPresent(String.self, forKey: .userId)
        verifyStatus = try values.decodeIfPresent(Int.self, forKey: .verifyStatus)
    }
}

struct HotComment: Codable {

    let commentId: String?
    let commentInfo: String?
    let isAuthor: Bool?
    let replyInfos: String?
    let rootItem: String?
    let userInfo: String?
    let userInteract: String?

    enum CodingKeys: String, CodingKey {
        case commentId = "comment_id"
        case commentInfo = "comment_info"
        case isAuthor = "is_author"
        case replyInfos = "reply_infos"
        case rootItem = "root_item"
        case userInfo = "user_info"
        case userInteract = "user_interact"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        commentId = try values.decodeIfPresent(String.self, forKey: .commentId)
        commentInfo = try values.decodeIfPresent(String.self, forKey: .commentInfo)
        isAuthor = try values.decodeIfPresent(Bool.self, forKey: .isAuthor)
        replyInfos = try values.decodeIfPresent(String.self, forKey: .replyInfos)
        rootItem = try values.decodeIfPresent(String.self, forKey: .rootItem)
        userInfo = try values.decodeIfPresent(String.self, forKey: .userInfo)
        userInteract = try values.decodeIfPresent(String.self, forKey: .userInteract)
    }
}

struct AuthorUserInfo: Codable {

    let accountAmount: Int?
    let annualInfo: [String]?
    let annualListType: Int?
    let articleCollectCountDaily: Int?
    let avatarLarge: String?
    let becomeAuthorDays: Int?
    let collectionSetArticleCount: Int?
    let company: String?
    let descriptionField: String?
    let diggArticleCount: Int?
    let diggShortmsgCount: Int?
    let favorableAuthor: Int?
    let followeeCount: Int?
    let followerCount: Int?
    let gotDiggCount: Int?
    let gotViewCount: Int?
    let identity: Int?
    let isLogout: Int?
    let isSelectAnnual: Bool?
    let isVip: Bool?
    let isfollowed: Bool?
    let jobTitle: String?
    let level: Int?
    let postArticleCount: Int?
    let postShortmsgCount: Int?
    let power: Int?
    let recommendArticleCountDaily: Int?
    let selectAnnualRank: Int?
    let selectEventCount: Int?
    let selectOnlineCourseCount: Int?
    let studentStatus: Int?
    let studyPoint: Int?
    let userGrowthInfo: UserGrowthInfo?
    let userId: String?
    let userName: String?

    enum CodingKeys: String, CodingKey {
        case accountAmount = "account_amount"
        case annualInfo = "annual_info"
        case annualListType = "annual_list_type"
        case articleCollectCountDaily = "article_collect_count_daily"
        case avatarLarge = "avatar_large"
        case becomeAuthorDays = "become_author_days"
        case collectionSetArticleCount = "collection_set_article_count"
        case company = "company"
        case descriptionField = "description"
        case diggArticleCount = "digg_article_count"
        case diggShortmsgCount = "digg_shortmsg_count"
        case favorableAuthor = "favorable_author"
        case followeeCount = "followee_count"
        case followerCount = "follower_count"
        case gotDiggCount = "got_digg_count"
        case gotViewCount = "got_view_count"
        case identity = "identity"
        case isLogout = "is_logout"
        case isSelectAnnual = "is_select_annual"
        case isVip = "is_vip"
        case isfollowed = "isfollowed"
        case jobTitle = "job_title"
        case level = "level"
        case postArticleCount = "post_article_count"
        case postShortmsgCount = "post_shortmsg_count"
        case power = "power"
        case recommendArticleCountDaily = "recommend_article_count_daily"
        case selectAnnualRank = "select_annual_rank"
        case selectEventCount = "select_event_count"
        case selectOnlineCourseCount = "select_online_course_count"
        case studentStatus = "student_status"
        case studyPoint = "study_point"
        case userGrowthInfo
        case userId = "user_id"
        case userName = "user_name"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        accountAmount = try values.decodeIfPresent(Int.self, forKey: .accountAmount)
        annualInfo = try values.decodeIfPresent([String].self, forKey: .annualInfo)
        annualListType = try values.decodeIfPresent(Int.self, forKey: .annualListType)
        articleCollectCountDaily = try values.decodeIfPresent(Int.self, forKey: .articleCollectCountDaily)
        avatarLarge = try values.decodeIfPresent(String.self, forKey: .avatarLarge)
        becomeAuthorDays = try values.decodeIfPresent(Int.self, forKey: .becomeAuthorDays)
        collectionSetArticleCount = try values.decodeIfPresent(Int.self, forKey: .collectionSetArticleCount)
        company = try values.decodeIfPresent(String.self, forKey: .company)
        descriptionField = try values.decodeIfPresent(String.self, forKey: .descriptionField)
        diggArticleCount = try values.decodeIfPresent(Int.self, forKey: .diggArticleCount)
        diggShortmsgCount = try values.decodeIfPresent(Int.self, forKey: .diggShortmsgCount)
        favorableAuthor = try values.decodeIfPresent(Int.self, forKey: .favorableAuthor)
        followeeCount = try values.decodeIfPresent(Int.self, forKey: .followeeCount)
        followerCount = try values.decodeIfPresent(Int.self, forKey: .followerCount)
        gotDiggCount = try values.decodeIfPresent(Int.self, forKey: .gotDiggCount)
        gotViewCount = try values.decodeIfPresent(Int.self, forKey: .gotViewCount)
        identity = try values.decodeIfPresent(Int.self, forKey: .identity)
        isLogout = try values.decodeIfPresent(Int.self, forKey: .isLogout)
        isSelectAnnual = try values.decodeIfPresent(Bool.self, forKey: .isSelectAnnual)
        isVip = try values.decodeIfPresent(Bool.self, forKey: .isVip)
        isfollowed = try values.decodeIfPresent(Bool.self, forKey: .isfollowed)
        jobTitle = try values.decodeIfPresent(String.self, forKey: .jobTitle)
        level = try values.decodeIfPresent(Int.self, forKey: .level)
        postArticleCount = try values.decodeIfPresent(Int.self, forKey: .postArticleCount)
        postShortmsgCount = try values.decodeIfPresent(Int.self, forKey: .postShortmsgCount)
        power = try values.decodeIfPresent(Int.self, forKey: .power)
        recommendArticleCountDaily = try values.decodeIfPresent(Int.self, forKey: .recommendArticleCountDaily)
        selectAnnualRank = try values.decodeIfPresent(Int.self, forKey: .selectAnnualRank)
        selectEventCount = try values.decodeIfPresent(Int.self, forKey: .selectEventCount)
        selectOnlineCourseCount = try values.decodeIfPresent(Int.self, forKey: .selectOnlineCourseCount)
        studentStatus = try values.decodeIfPresent(Int.self, forKey: .studentStatus)
        studyPoint = try values.decodeIfPresent(Int.self, forKey: .studyPoint)
        userGrowthInfo = try values.decodeIfPresent(UserGrowthInfo.self, forKey: .userGrowthInfo)
        userId = try values.decodeIfPresent(String.self, forKey: .userId)
        userName = try values.decodeIfPresent(String.self, forKey: .userName)
    }
}

struct UserGrowthInfo: Codable {

    let authorAchievementList: [String]?
    let jpower: Int?
    let jpowerLevel: Int?
    let jscore: Float?
    let jscoreLevel: Int?
    let jscoreNextLevelScore: Int?
    let jscoreThisLevelMiniScore: Int?
    let jscoreTitle: String?
    let userId: Int?
    let vipLevel: Int?
    let vipTitle: String?

    enum CodingKeys: String, CodingKey {
        case authorAchievementList = "author_achievement_list"
        case jpower = "jpower"
        case jpowerLevel = "jpower_level"
        case jscore = "jscore"
        case jscoreLevel = "jscore_level"
        case jscoreNextLevelScore = "jscore_next_level_score"
        case jscoreThisLevelMiniScore = "jscore_this_level_mini_score"
        case jscoreTitle = "jscore_title"
        case userId = "user_id"
        case vipLevel = "vip_level"
        case vipTitle = "vip_title"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        authorAchievementList = try values.decodeIfPresent([String].self, forKey: .authorAchievementList)
        jpower = try values.decodeIfPresent(Int.self, forKey: .jpower)
        jpowerLevel = try values.decodeIfPresent(Int.self, forKey: .jpowerLevel)
        jscore = try values.decodeIfPresent(Float.self, forKey: .jscore)
        jscoreLevel = try values.decodeIfPresent(Int.self, forKey: .jscoreLevel)
        jscoreNextLevelScore = try values.decodeIfPresent(Int.self, forKey: .jscoreNextLevelScore)
        jscoreThisLevelMiniScore = try values.decodeIfPresent(Int.self, forKey: .jscoreThisLevelMiniScore)
        jscoreTitle = try values.decodeIfPresent(String.self, forKey: .jscoreTitle)
        userId = try values.decodeIfPresent(Int.self, forKey: .userId)
        vipLevel = try values.decodeIfPresent(Int.self, forKey: .vipLevel)
        vipTitle = try values.decodeIfPresent(String.self, forKey: .vipTitle)
    }
}
