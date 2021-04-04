# frozen_string_literal: true

describe TravelPostHelper do
  include TravelPostHelper

  let(:sample_post_filename) { "2020-06-01.markdown" }
  let(:sample_post_date) { "2020-06-01" }
  let(:sample_post_url) { "/travel/posts/#{sample_post_date}" }
  let(:sample_post_title) { "Title" }
  let(:sample_post) do
    [
      "# #{sample_post_title}",
      "",
      "Lorem ipsum, dolor sit amet consectetur adipisicing elit. Exercitationem accusamus, sequi delectus quia sit",
      "officia quod repellendus omnis placeat. Aut ex voluptas exercitationem iusto esse dolore. Accusantium facere",
      "temporibus sunt.",
    ]
  end
  let(:sample_post_excerpt) { sample_post[2][0, 100] + "..." }

  describe "#travel_post_title" do
    context "when using sample data" do
      subject { travel_post_title(sample_post) }

      it { is_expected.to(eq(sample_post_title)) }
    end
  end

  describe "#travel_post_excerpt" do
    context "when using sample data" do
      subject { travel_post_excerpt(sample_post) }

      it { is_expected.to(eq(sample_post_excerpt)) }
    end
  end

  describe "#travel_post_url" do
    context "when using sample data" do
      subject { travel_post_url(sample_post_date) }

      it { is_expected.to(eq(sample_post_url)) }
    end
  end

  describe "#travel_post_date" do
    context "when using sample data" do
      subject { travel_post_date(sample_post_filename) }

      it { is_expected.to(eq(sample_post_date)) }
    end
  end
end
