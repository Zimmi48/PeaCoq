// import { CoqXMLTag, mkCoqXMLTag } from "./xml-tag"

class CoqXMLTree {
  public rootLabel: Located<CoqXMLTag>
  public subForest: CoqXMLTree[]
  constructor(t: [CoqLocation, ICoqtopResponse<any>]) {
    const [loc, xmltag] = t
    this.rootLabel = [loc, mkCoqXMLTag(xmltag)]
    this.subForest = _(t[1]).map((t: [CoqLocation, ICoqtopResponse<any>]) => {
      return new CoqXMLTree(t)
    }).value()
  }
  public toString(depth: number) {
    let res = ""
    if (typeof depth === "undefined") {
      depth = 0
    }
    _(_.range(depth)).each(() => {
      res += "  "
    })
    res += "`- " + this.rootLabel.toString() + "\n"
    _(this.subForest).each((t: CoqXMLTree) => {
      res += t.toString(depth + 1)
    })
    return res
  }
}
