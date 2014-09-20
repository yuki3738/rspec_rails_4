require'spec_helper'

describe Contact do
  # 有効なファクトリを持つこと
  it "has a vlaid factory" do
    expect(build(:contact)).to be_valid
  end

  # 姓と名とメールがあれば有効な状態であること
  it "is valid with a firstname, lastname and email" do
    contact = Contact.new(
      firstname: 'Aaron',
      lastname: 'Sumber',
      email: 'tester@example.com')
      expect(contact).to be_valid
    end

  # 名がなければ無効な状態であること
  it "is invalid without a firstname" do
    contact = build(:contact, firstname: nil)
    expect(contact).to have(1).errors_on(:firstname)
  end

  # 姓がなければ無効な状態であること
  it "is invalid without a lastname" do
    ontact = build(:contact, lastname: nil)
    expect(contact).to have(1).errors_on(:lastname)
  end

  # メールアドレスがなければ無効な状態であること
  it "is invalid without an email address" do
    contact = build(:contact, email: nil)
    expect(contact).to have(1).errors_on(:email)
  end

  # 重複したメールアドレスなら無効な状態であること
  it "is invalid with a duplicate email address" do
    create(:contact, email: "aaron@example.com")
    contact = build(:contact, email: "aaron@example.com")
    expect(contact).to have(1).errors_on(:email)
  end

  # 連絡先のフルネームを文字列として返すこと
  it "returns a contact's full name as a string" do
    contact = FactoryGirl.build(:contact,
      firstname: "Jane", lastname: "Doe")
      expect(contact.name).to eq 'John Doe'
  end

  # 文字で姓をフィルタする
  describe "filter last name by letter" do
    before :each do
      @smith = Contact.create(firstname: 'John', lastname: 'Smith',
        email: 'jsmith@example.com')
      @jones = Contact.create(firstname: 'Tim', lastname: 'Jones',
        email: 'tjones@example.com')
      @johnson = Contact.create(firstname: 'John', lastname: 'Johnson',
        email: 'jjohnson@example.com')
    end

    # マッチする文字の場合
    context "matching letters" do
      # マッチした結果をソート済みの配列として返すこと
      it "returns a sorted array of results that match" do
        expect(Contact.by_letter("J")).to eq [@johnson, @jones]
      end
    end

    # マッチする文字の場合
    context "non-matching letters" do
      # マッチした結果をソート済みの配列として返すこと
      it "returns a sorted array of results that match" do
        expect(Contact.by_letter("J")).to_not include @smith
      end
    end
  end
end
